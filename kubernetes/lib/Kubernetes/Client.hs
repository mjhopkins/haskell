{-
   Kubernetes

   No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

   OpenAPI spec version: 2.0
   Kubernetes API version: v1.9.2
   Generated by Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
-}

{-|
Module : Kubernetes.Client
-}

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveFoldable #-}
{-# LANGUAGE DeriveTraversable #-}
{-# OPTIONS_GHC -fno-warn-unused-binds -fno-warn-unused-imports #-}

module Kubernetes.Client where

import Kubernetes.Core
import Kubernetes.Logging
import Kubernetes.MimeTypes

import qualified Control.Exception.Safe as E
import qualified Control.Monad.IO.Class as P
import qualified Control.Monad as P
import qualified Data.Aeson.Types as A
import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BCL
import qualified Data.Proxy as P (Proxy(..))
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Network.HTTP.Client as NH
import qualified Network.HTTP.Client.MultipartFormData as NH
import qualified Network.HTTP.Types as NH
import qualified Web.FormUrlEncoded as WH
import qualified Web.HttpApiData as WH

import Data.Function ((&))
import Data.Monoid ((<>))
import Data.Text (Text)
import GHC.Exts (IsString(..))

-- * Dispatch

-- ** Lbs

-- | send a request returning the raw http response
dispatchLbs
  :: (Produces req accept, MimeType contentType)
  => NH.Manager -- ^ http-client Connection manager
  -> KubernetesConfig -- ^ config
  -> KubernetesRequest req contentType res accept -- ^ request
  -> IO (NH.Response BCL.ByteString) -- ^ response
dispatchLbs manager config request  = do
  initReq <- _toInitRequest config request
  dispatchInitUnsafe manager config initReq

-- ** Mime

-- | pair of decoded http body and http response
data MimeResult res =
  MimeResult { mimeResult :: Either MimeError res -- ^ decoded http body
             , mimeResultResponse :: NH.Response BCL.ByteString -- ^ http response 
             }
  deriving (Show, Functor, Foldable, Traversable)

-- | pair of unrender/parser error and http response
data MimeError =
  MimeError {
    mimeError :: String -- ^ unrender/parser error
  , mimeErrorResponse :: NH.Response BCL.ByteString -- ^ http response 
  } deriving (Eq, Show)

-- | send a request returning the 'MimeResult'
dispatchMime
  :: forall req contentType res accept. (Produces req accept, MimeUnrender accept res, MimeType contentType)
  => NH.Manager -- ^ http-client Connection manager
  -> KubernetesConfig -- ^ config
  -> KubernetesRequest req contentType res accept -- ^ request
  -> IO (MimeResult res) -- ^ response
dispatchMime manager config request = do
  httpResponse <- dispatchLbs manager config request
  let statusCode = NH.statusCode . NH.responseStatus $ httpResponse
  parsedResult <-
    runConfigLogWithExceptions "Client" config $
    do if (statusCode >= 400 && statusCode < 600)
         then do
           let s = "error statusCode: " ++ show statusCode
           _log "Client" levelError (T.pack s)
           pure (Left (MimeError s httpResponse))
         else case mimeUnrender (P.Proxy :: P.Proxy accept) (NH.responseBody httpResponse) of
           Left s -> do
             _log "Client" levelError (T.pack s)
             pure (Left (MimeError s httpResponse))
           Right r -> pure (Right r)
  return (MimeResult parsedResult httpResponse)

-- | like 'dispatchMime', but only returns the decoded http body
dispatchMime'
  :: (Produces req accept, MimeUnrender accept res, MimeType contentType)
  => NH.Manager -- ^ http-client Connection manager
  -> KubernetesConfig -- ^ config
  -> KubernetesRequest req contentType res accept -- ^ request
  -> IO (Either MimeError res) -- ^ response
dispatchMime' manager config request  = do
    MimeResult parsedResult _ <- dispatchMime manager config request
    return parsedResult

-- ** Unsafe

-- | like 'dispatchReqLbs', but does not validate the operation is a 'Producer' of the "accept" 'MimeType'.  (Useful if the server's response is undocumented)
dispatchLbsUnsafe
  :: (MimeType accept, MimeType contentType)
  => NH.Manager -- ^ http-client Connection manager
  -> KubernetesConfig -- ^ config
  -> KubernetesRequest req contentType res accept -- ^ request
  -> IO (NH.Response BCL.ByteString) -- ^ response
dispatchLbsUnsafe manager config request  = do
  initReq <- _toInitRequest config request
  dispatchInitUnsafe manager config initReq

-- | dispatch an InitRequest
dispatchInitUnsafe
  :: NH.Manager -- ^ http-client Connection manager
  -> KubernetesConfig -- ^ config
  -> InitRequest req contentType res accept -- ^ init request
  -> IO (NH.Response BCL.ByteString) -- ^ response
dispatchInitUnsafe manager config (InitRequest req) = do
  runConfigLogWithExceptions src config $
    do _log src levelInfo requestLogMsg
       _log src levelDebug requestDbgLogMsg
       res <- P.liftIO $ NH.httpLbs req manager
       _log src levelInfo (responseLogMsg res)
       _log src levelDebug ((T.pack . show) res)
       return res
  where
    src = "Client"
    endpoint =
      T.pack $
      BC.unpack $
      NH.method req <> " " <> NH.host req <> NH.path req <> NH.queryString req
    requestLogMsg = "REQ:" <> endpoint
    requestDbgLogMsg =
      "Headers=" <> (T.pack . show) (NH.requestHeaders req) <> " Body=" <>
      (case NH.requestBody req of
         NH.RequestBodyLBS xs -> T.decodeUtf8 (BL.toStrict xs)
         _ -> "<RequestBody>")
    responseStatusCode = (T.pack . show) . NH.statusCode . NH.responseStatus
    responseLogMsg res =
      "RES:statusCode=" <> responseStatusCode res <> " (" <> endpoint <> ")"

-- * InitRequest

-- | wraps an http-client 'Request' with request/response type parameters
newtype InitRequest req contentType res accept = InitRequest
  { unInitRequest :: NH.Request
  } deriving (Show)

-- |  Build an http-client 'Request' record from the supplied config and request
_toInitRequest
  :: (MimeType accept, MimeType contentType)
  => KubernetesConfig -- ^ config
  -> KubernetesRequest req contentType res accept -- ^ request
  -> IO (InitRequest req contentType res accept) -- ^ initialized request
_toInitRequest config req0  = 
  runConfigLogWithExceptions "Client" config $ do
    parsedReq <- P.liftIO $ NH.parseRequest $ BCL.unpack $ BCL.append (configHost config) (BCL.concat (rUrlPath req0))
    req1 <- P.liftIO $ _applyAuthMethods req0 config
    P.when
        (configValidateAuthMethods config && (not . null . rAuthTypes) req1)
        (E.throw $ AuthMethodException $ "AuthMethod not configured: " <> (show . head . rAuthTypes) req1)
    let req2 = req1 & _setContentTypeHeader & _setAcceptHeader
        reqHeaders = ("User-Agent", WH.toHeader (configUserAgent config)) : paramsHeaders (rParams req2)
        reqQuery = NH.renderQuery True (paramsQuery (rParams req2))
        pReq = parsedReq { NH.method = (rMethod req2)
                        , NH.requestHeaders = reqHeaders
                        , NH.queryString = reqQuery
                        }
    outReq <- case paramsBody (rParams req2) of
        ParamBodyNone -> pure (pReq { NH.requestBody = mempty })
        ParamBodyB bs -> pure (pReq { NH.requestBody = NH.RequestBodyBS bs })
        ParamBodyBL bl -> pure (pReq { NH.requestBody = NH.RequestBodyLBS bl })
        ParamBodyFormUrlEncoded form -> pure (pReq { NH.requestBody = NH.RequestBodyLBS (WH.urlEncodeForm form) })
        ParamBodyMultipartFormData parts -> NH.formDataBody parts pReq

    pure (InitRequest outReq)

-- | modify the underlying Request
modifyInitRequest :: InitRequest req contentType res accept -> (NH.Request -> NH.Request) -> InitRequest req contentType res accept
modifyInitRequest (InitRequest req) f = InitRequest (f req)

-- | modify the underlying Request (monadic)
modifyInitRequestM :: Monad m => InitRequest req contentType res accept -> (NH.Request -> m NH.Request) -> m (InitRequest req contentType res accept)
modifyInitRequestM (InitRequest req) f = fmap InitRequest (f req)

-- ** Logging 

-- | Run a block using the configured logger instance
runConfigLog
  :: P.MonadIO m
  => KubernetesConfig -> LogExec m
runConfigLog config = configLogExecWithContext config (configLogContext config)

-- | Run a block using the configured logger instance (logs exceptions)
runConfigLogWithExceptions
  :: (E.MonadCatch m, P.MonadIO m)
  => T.Text -> KubernetesConfig -> LogExec m
runConfigLogWithExceptions src config = runConfigLog config . logExceptions src
