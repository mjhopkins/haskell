{-
   Kubernetes

   No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

   OpenAPI spec version: 2.0
   Kubernetes API version: v1.9.2
   Generated by Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
-}

{-|
Module : Kubernetes.API.AdmissionregistrationV1alpha1
-}

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing -fno-warn-unused-binds -fno-warn-unused-imports #-}

module Kubernetes.API.AdmissionregistrationV1alpha1 where

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


-- ** AdmissionregistrationV1alpha1

-- *** createInitializerConfiguration

-- | @POST \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations@
-- 
-- create an InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
createInitializerConfiguration 
  :: (Consumes CreateInitializerConfiguration contentType, MimeRender contentType V1alpha1InitializerConfiguration)
  => ContentType contentType -- ^ request content-type ('MimeType')
  -> Accept accept -- ^ request accept ('MimeType')
  -> V1alpha1InitializerConfiguration -- ^ "body"
  -> KubernetesRequest CreateInitializerConfiguration contentType V1alpha1InitializerConfiguration accept
createInitializerConfiguration _  _ body =
  _mkRequest "POST" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)
    `setBodyParam` body

data CreateInitializerConfiguration 
instance HasBodyParam CreateInitializerConfiguration V1alpha1InitializerConfiguration 

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam CreateInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes CreateInitializerConfiguration mtype

-- | @application/json@
instance Produces CreateInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces CreateInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces CreateInitializerConfiguration MimeVndKubernetesProtobuf


-- *** deleteCollectionInitializerConfiguration

-- | @DELETE \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations@
-- 
-- delete collection of InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
deleteCollectionInitializerConfiguration 
  :: Accept accept -- ^ request accept ('MimeType')
  -> KubernetesRequest DeleteCollectionInitializerConfiguration MimeNoContent V1Status accept
deleteCollectionInitializerConfiguration  _ =
  _mkRequest "DELETE" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)

data DeleteCollectionInitializerConfiguration  

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam DeleteCollectionInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | /Optional Param/ "continue" - The continue option should be set when retrieving more results from the server. Since this value is server defined, clients may only use the continue value from a previous query result with identical query parameters (except for the value of continue) and the server may reject a continue value it does not recognize. If the specified continue value is no longer valid whether due to expiration (generally five to fifteen minutes) or a configuration change on the server the server will respond with a 410 ResourceExpired error indicating the client must restart their list without the continue field. This field is not supported when watch is true. Clients may start a watch from the last resourceVersion value returned by the server and not miss any modifications.
instance HasOptionalParam DeleteCollectionInitializerConfiguration Continue where
  applyOptionalParam req (Continue xs) =
    req `setQuery` toQuery ("continue", Just xs)

-- | /Optional Param/ "fieldSelector" - A selector to restrict the list of returned objects by their fields. Defaults to everything.
instance HasOptionalParam DeleteCollectionInitializerConfiguration FieldSelector where
  applyOptionalParam req (FieldSelector xs) =
    req `setQuery` toQuery ("fieldSelector", Just xs)

-- | /Optional Param/ "includeUninitialized" - If true, partially initialized resources are included in the response.
instance HasOptionalParam DeleteCollectionInitializerConfiguration IncludeUninitialized where
  applyOptionalParam req (IncludeUninitialized xs) =
    req `setQuery` toQuery ("includeUninitialized", Just xs)

-- | /Optional Param/ "labelSelector" - A selector to restrict the list of returned objects by their labels. Defaults to everything.
instance HasOptionalParam DeleteCollectionInitializerConfiguration LabelSelector where
  applyOptionalParam req (LabelSelector xs) =
    req `setQuery` toQuery ("labelSelector", Just xs)

-- | /Optional Param/ "limit" - limit is a maximum number of responses to return for a list call. If more items exist, the server will set the `continue` field on the list metadata to a value that can be used with the same initial query to retrieve the next set of results. Setting a limit may return fewer than the requested amount of items (up to zero items) in the event all requested objects are filtered out and clients should only use the presence of the continue field to determine whether more results are available. Servers may choose not to support the limit argument and will return all of the available results. If limit is specified and the continue field is empty, clients may assume that no more results are available. This field is not supported if watch is true.  The server guarantees that the objects returned when using continue will be identical to issuing a single list call without a limit - that is, no objects created, modified, or deleted after the first request is issued will be included in any subsequent continued requests. This is sometimes referred to as a consistent snapshot, and ensures that a client that is using limit to receive smaller chunks of a very large result can ensure they see all possible objects. If objects are updated during a chunked list the version of the object that was present at the time the first list result was calculated is returned.
instance HasOptionalParam DeleteCollectionInitializerConfiguration Limit where
  applyOptionalParam req (Limit xs) =
    req `setQuery` toQuery ("limit", Just xs)

-- | /Optional Param/ "resourceVersion" - When specified with a watch call, shows changes that occur after that particular version of a resource. Defaults to changes from the beginning of history. When specified for list: - if unset, then the result is returned from remote storage based on quorum-read flag; - if it's 0, then we simply return what we currently have in cache, no guarantee; - if set to non zero, then the result is at least as fresh as given rv.
instance HasOptionalParam DeleteCollectionInitializerConfiguration ResourceVersion where
  applyOptionalParam req (ResourceVersion xs) =
    req `setQuery` toQuery ("resourceVersion", Just xs)

-- | /Optional Param/ "timeoutSeconds" - Timeout for the list/watch call.
instance HasOptionalParam DeleteCollectionInitializerConfiguration TimeoutSeconds where
  applyOptionalParam req (TimeoutSeconds xs) =
    req `setQuery` toQuery ("timeoutSeconds", Just xs)

-- | /Optional Param/ "watch" - Watch for changes to the described resources and return them as a stream of add, update, and remove notifications. Specify resourceVersion.
instance HasOptionalParam DeleteCollectionInitializerConfiguration Watch where
  applyOptionalParam req (Watch xs) =
    req `setQuery` toQuery ("watch", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes DeleteCollectionInitializerConfiguration mtype

-- | @application/json@
instance Produces DeleteCollectionInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces DeleteCollectionInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces DeleteCollectionInitializerConfiguration MimeVndKubernetesProtobuf


-- *** deleteInitializerConfiguration

-- | @DELETE \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations\/{name}@
-- 
-- delete an InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
deleteInitializerConfiguration 
  :: (Consumes DeleteInitializerConfiguration contentType, MimeRender contentType V1DeleteOptions)
  => ContentType contentType -- ^ request content-type ('MimeType')
  -> Accept accept -- ^ request accept ('MimeType')
  -> Name -- ^ "name" -  name of the InitializerConfiguration
  -> V1DeleteOptions -- ^ "body"
  -> KubernetesRequest DeleteInitializerConfiguration contentType V1Status accept
deleteInitializerConfiguration _  _ (Name name) body =
  _mkRequest "DELETE" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations/",toPath name]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)
    `setBodyParam` body

data DeleteInitializerConfiguration 
instance HasBodyParam DeleteInitializerConfiguration V1DeleteOptions 

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam DeleteInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | /Optional Param/ "gracePeriodSeconds" - The duration in seconds before the object should be deleted. Value must be non-negative integer. The value zero indicates delete immediately. If this value is nil, the default grace period for the specified type will be used. Defaults to a per object value if not specified. zero means delete immediately.
instance HasOptionalParam DeleteInitializerConfiguration GracePeriodSeconds where
  applyOptionalParam req (GracePeriodSeconds xs) =
    req `setQuery` toQuery ("gracePeriodSeconds", Just xs)

-- | /Optional Param/ "orphanDependents" - Deprecated: please use the PropagationPolicy, this field will be deprecated in 1.7. Should the dependent objects be orphaned. If true/false, the \"orphan\" finalizer will be added to/removed from the object's finalizers list. Either this field or PropagationPolicy may be set, but not both.
instance HasOptionalParam DeleteInitializerConfiguration OrphanDependents where
  applyOptionalParam req (OrphanDependents xs) =
    req `setQuery` toQuery ("orphanDependents", Just xs)

-- | /Optional Param/ "propagationPolicy" - Whether and how garbage collection will be performed. Either this field or OrphanDependents may be set, but not both. The default policy is decided by the existing finalizer set in the metadata.finalizers and the resource-specific default policy. Acceptable values are: 'Orphan' - orphan the dependents; 'Background' - allow the garbage collector to delete the dependents in the background; 'Foreground' - a cascading policy that deletes all dependents in the foreground.
instance HasOptionalParam DeleteInitializerConfiguration PropagationPolicy where
  applyOptionalParam req (PropagationPolicy xs) =
    req `setQuery` toQuery ("propagationPolicy", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes DeleteInitializerConfiguration mtype

-- | @application/json@
instance Produces DeleteInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces DeleteInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces DeleteInitializerConfiguration MimeVndKubernetesProtobuf


-- *** getAPIResources

-- | @GET \/apis\/admissionregistration.k8s.io\/v1alpha1\/@
-- 
-- get available resources
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
getAPIResources 
  :: Accept accept -- ^ request accept ('MimeType')
  -> KubernetesRequest GetAPIResources MimeNoContent V1APIResourceList accept
getAPIResources  _ =
  _mkRequest "GET" ["/apis/admissionregistration.k8s.io/v1alpha1/"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)

data GetAPIResources  

-- | @application/json@
instance Consumes GetAPIResources MimeJSON
-- | @application/yaml@
instance Consumes GetAPIResources MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Consumes GetAPIResources MimeVndKubernetesProtobuf

-- | @application/json@
instance Produces GetAPIResources MimeJSON
-- | @application/yaml@
instance Produces GetAPIResources MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces GetAPIResources MimeVndKubernetesProtobuf


-- *** listInitializerConfiguration

-- | @GET \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations@
-- 
-- list or watch objects of kind InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
listInitializerConfiguration 
  :: Accept accept -- ^ request accept ('MimeType')
  -> KubernetesRequest ListInitializerConfiguration MimeNoContent V1alpha1InitializerConfigurationList accept
listInitializerConfiguration  _ =
  _mkRequest "GET" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations"]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)

data ListInitializerConfiguration  

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam ListInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | /Optional Param/ "continue" - The continue option should be set when retrieving more results from the server. Since this value is server defined, clients may only use the continue value from a previous query result with identical query parameters (except for the value of continue) and the server may reject a continue value it does not recognize. If the specified continue value is no longer valid whether due to expiration (generally five to fifteen minutes) or a configuration change on the server the server will respond with a 410 ResourceExpired error indicating the client must restart their list without the continue field. This field is not supported when watch is true. Clients may start a watch from the last resourceVersion value returned by the server and not miss any modifications.
instance HasOptionalParam ListInitializerConfiguration Continue where
  applyOptionalParam req (Continue xs) =
    req `setQuery` toQuery ("continue", Just xs)

-- | /Optional Param/ "fieldSelector" - A selector to restrict the list of returned objects by their fields. Defaults to everything.
instance HasOptionalParam ListInitializerConfiguration FieldSelector where
  applyOptionalParam req (FieldSelector xs) =
    req `setQuery` toQuery ("fieldSelector", Just xs)

-- | /Optional Param/ "includeUninitialized" - If true, partially initialized resources are included in the response.
instance HasOptionalParam ListInitializerConfiguration IncludeUninitialized where
  applyOptionalParam req (IncludeUninitialized xs) =
    req `setQuery` toQuery ("includeUninitialized", Just xs)

-- | /Optional Param/ "labelSelector" - A selector to restrict the list of returned objects by their labels. Defaults to everything.
instance HasOptionalParam ListInitializerConfiguration LabelSelector where
  applyOptionalParam req (LabelSelector xs) =
    req `setQuery` toQuery ("labelSelector", Just xs)

-- | /Optional Param/ "limit" - limit is a maximum number of responses to return for a list call. If more items exist, the server will set the `continue` field on the list metadata to a value that can be used with the same initial query to retrieve the next set of results. Setting a limit may return fewer than the requested amount of items (up to zero items) in the event all requested objects are filtered out and clients should only use the presence of the continue field to determine whether more results are available. Servers may choose not to support the limit argument and will return all of the available results. If limit is specified and the continue field is empty, clients may assume that no more results are available. This field is not supported if watch is true.  The server guarantees that the objects returned when using continue will be identical to issuing a single list call without a limit - that is, no objects created, modified, or deleted after the first request is issued will be included in any subsequent continued requests. This is sometimes referred to as a consistent snapshot, and ensures that a client that is using limit to receive smaller chunks of a very large result can ensure they see all possible objects. If objects are updated during a chunked list the version of the object that was present at the time the first list result was calculated is returned.
instance HasOptionalParam ListInitializerConfiguration Limit where
  applyOptionalParam req (Limit xs) =
    req `setQuery` toQuery ("limit", Just xs)

-- | /Optional Param/ "resourceVersion" - When specified with a watch call, shows changes that occur after that particular version of a resource. Defaults to changes from the beginning of history. When specified for list: - if unset, then the result is returned from remote storage based on quorum-read flag; - if it's 0, then we simply return what we currently have in cache, no guarantee; - if set to non zero, then the result is at least as fresh as given rv.
instance HasOptionalParam ListInitializerConfiguration ResourceVersion where
  applyOptionalParam req (ResourceVersion xs) =
    req `setQuery` toQuery ("resourceVersion", Just xs)

-- | /Optional Param/ "timeoutSeconds" - Timeout for the list/watch call.
instance HasOptionalParam ListInitializerConfiguration TimeoutSeconds where
  applyOptionalParam req (TimeoutSeconds xs) =
    req `setQuery` toQuery ("timeoutSeconds", Just xs)

-- | /Optional Param/ "watch" - Watch for changes to the described resources and return them as a stream of add, update, and remove notifications. Specify resourceVersion.
instance HasOptionalParam ListInitializerConfiguration Watch where
  applyOptionalParam req (Watch xs) =
    req `setQuery` toQuery ("watch", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes ListInitializerConfiguration mtype

-- | @application/json@
instance Produces ListInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces ListInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces ListInitializerConfiguration MimeVndKubernetesProtobuf
-- | @application/json;stream=watch@
instance Produces ListInitializerConfiguration MimeJsonstreamwatch
-- | @application/vnd.kubernetes.protobuf;stream=watch@
instance Produces ListInitializerConfiguration MimeVndKubernetesProtobufstreamwatch


-- *** patchInitializerConfiguration

-- | @PATCH \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations\/{name}@
-- 
-- partially update the specified InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
patchInitializerConfiguration 
  :: (Consumes PatchInitializerConfiguration contentType, MimeRender contentType A.Value)
  => ContentType contentType -- ^ request content-type ('MimeType')
  -> Accept accept -- ^ request accept ('MimeType')
  -> Name -- ^ "name" -  name of the InitializerConfiguration
  -> A.Value -- ^ "body"
  -> KubernetesRequest PatchInitializerConfiguration contentType V1alpha1InitializerConfiguration accept
patchInitializerConfiguration _  _ (Name name) body =
  _mkRequest "PATCH" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations/",toPath name]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)
    `setBodyParam` body

data PatchInitializerConfiguration 
instance HasBodyParam PatchInitializerConfiguration A.Value 

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam PatchInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | @application/json-patch+json@
instance Consumes PatchInitializerConfiguration MimeJsonPatchjson
-- | @application/merge-patch+json@
instance Consumes PatchInitializerConfiguration MimeMergePatchjson
-- | @application/strategic-merge-patch+json@
instance Consumes PatchInitializerConfiguration MimeStrategicMergePatchjson

-- | @application/json@
instance Produces PatchInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces PatchInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces PatchInitializerConfiguration MimeVndKubernetesProtobuf


-- *** readInitializerConfiguration

-- | @GET \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations\/{name}@
-- 
-- read the specified InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
readInitializerConfiguration 
  :: Accept accept -- ^ request accept ('MimeType')
  -> Name -- ^ "name" -  name of the InitializerConfiguration
  -> KubernetesRequest ReadInitializerConfiguration MimeNoContent V1alpha1InitializerConfiguration accept
readInitializerConfiguration  _ (Name name) =
  _mkRequest "GET" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations/",toPath name]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)

data ReadInitializerConfiguration  

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam ReadInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | /Optional Param/ "exact" - Should the export be exact.  Exact export maintains cluster-specific fields like 'Namespace'.
instance HasOptionalParam ReadInitializerConfiguration Exact where
  applyOptionalParam req (Exact xs) =
    req `setQuery` toQuery ("exact", Just xs)

-- | /Optional Param/ "export" - Should this value be exported.  Export strips fields that a user can not specify.
instance HasOptionalParam ReadInitializerConfiguration Export where
  applyOptionalParam req (Export xs) =
    req `setQuery` toQuery ("export", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes ReadInitializerConfiguration mtype

-- | @application/json@
instance Produces ReadInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces ReadInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces ReadInitializerConfiguration MimeVndKubernetesProtobuf


-- *** replaceInitializerConfiguration

-- | @PUT \/apis\/admissionregistration.k8s.io\/v1alpha1\/initializerconfigurations\/{name}@
-- 
-- replace the specified InitializerConfiguration
-- 
-- AuthMethod: 'AuthApiKeyBearerToken'
-- 
replaceInitializerConfiguration 
  :: (Consumes ReplaceInitializerConfiguration contentType, MimeRender contentType V1alpha1InitializerConfiguration)
  => ContentType contentType -- ^ request content-type ('MimeType')
  -> Accept accept -- ^ request accept ('MimeType')
  -> Name -- ^ "name" -  name of the InitializerConfiguration
  -> V1alpha1InitializerConfiguration -- ^ "body"
  -> KubernetesRequest ReplaceInitializerConfiguration contentType V1alpha1InitializerConfiguration accept
replaceInitializerConfiguration _  _ (Name name) body =
  _mkRequest "PUT" ["/apis/admissionregistration.k8s.io/v1alpha1/initializerconfigurations/",toPath name]
    `_hasAuthType` (P.Proxy :: P.Proxy AuthApiKeyBearerToken)
    `setBodyParam` body

data ReplaceInitializerConfiguration 
instance HasBodyParam ReplaceInitializerConfiguration V1alpha1InitializerConfiguration 

-- | /Optional Param/ "pretty" - If 'true', then the output is pretty printed.
instance HasOptionalParam ReplaceInitializerConfiguration Pretty where
  applyOptionalParam req (Pretty xs) =
    req `setQuery` toQuery ("pretty", Just xs)

-- | @*/*@
instance MimeType mtype => Consumes ReplaceInitializerConfiguration mtype

-- | @application/json@
instance Produces ReplaceInitializerConfiguration MimeJSON
-- | @application/yaml@
instance Produces ReplaceInitializerConfiguration MimeYaml
-- | @application/vnd.kubernetes.protobuf@
instance Produces ReplaceInitializerConfiguration MimeVndKubernetesProtobuf

