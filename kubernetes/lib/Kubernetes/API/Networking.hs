{-
   Kubernetes

   No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

   OpenAPI spec version: 2.0
   Kubernetes API version: v1.9.2
   Generated by Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
-}

{-|
Module : Kubernetes.API.Networking
-}

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing -fno-warn-unused-binds -fno-warn-unused-imports #-}

module Kubernetes.API.Networking where

import Kubernetes.Core
import Kubernetes.MimeTypes
import Kubernetes.Model as M

import qualified Data.Aeson as A
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Data as P (Typeable, TypeRep, typeOf, typeRep)
import qualified Data.Foldable as P
import qualified Data.Map as Map
import qualified Data.Maybe as P
import qualified Data.Proxy as P (Proxy(..))
import qualified Data.Set as Set
import qualified Data.String as P
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.Time as TI
import qualified Network.HTTP.Client.MultipartFormData as NH
import qualified Network.HTTP.Media as ME
import qualified Network.HTTP.Types as NH
import qualified Web.FormUrlEncoded as WH
import qualified Web.HttpApiData as WH

import Data.Text (Text)
import GHC.Base ((<|>))

import Prelude ((==),(/=),($), (.),(<$>),(<*>),(>>=),Maybe(..),Bool(..),Char,Double,FilePath,Float,Int,Integer,String,fmap,undefined,mempty,maybe,pure,Monad,Applicative,Functor)
import qualified Prelude as P

-- * Operations


-- ** Networking

-- *** getAPIGroup

-- | @GET \/apis\/networking.k8s.io\/@
-- 
-- get information of a group
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
getAPIGroup 
  :: Accept accept -- ^ request accept ('MimeType')
  -> KubernetesRequest GetAPIGroup MimeNoContent V1APIGroup accept
getAPIGroup  _ =
  _mkRequest "GET" ["/apis/networking.k8s.io/"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)

data GetAPIGroup  

-- | @application/json@
instance Consumes GetAPIGroup MimeJSON
-- | @application/yaml@
instance Consumes GetAPIGroup MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Consumes GetAPIGroup MimeVndKubernetesProtobuf

-- | @application/json@
instance Produces GetAPIGroup MimeJSON
-- | @application/yaml@
instance Produces GetAPIGroup MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces GetAPIGroup MimeVndKubernetesProtobuf

