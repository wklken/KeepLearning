#!/usr/bin/env python
# encoding: utf-8

"""
Tornado的auth模块为OpenID、OAuth、OAuth 2.0、Twitter、FriendFeed、Google OpenID、Facebook REST API和Facebook Graph API提供了相应的类。

尽管你可以自己实现对于特定外部服务认证过程的处理，不过Tornado的auth模块为连接任何支持的服务开发应用提供了简单的工作流程


这些认证方法的工作流程虽然有一些轻微的不同，但对于大多数而言，都使用了authorize_redirect和get_authenticated_user方法。

authorize_rediect方法用来将一个未授权用户重定向到外部服务的验证页面。
在验证页面中，用户登录服务，并让你的应用拥有访问他账户的权限。
通常情况下，你会在用户带着一个临时访问码返回你的应用时使用get_authenticated_user方法。

调用get_authenticated_user方法会把授权跳转过程提供的临时凭证替换成属于用户的长期凭证。
Twitter、Facebook、FriendFeed和Google的具体验证类提供了他们自己的函数来使API调用它们的服务。
"""
