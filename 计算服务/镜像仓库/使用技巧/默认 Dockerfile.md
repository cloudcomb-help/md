# 默认 Dockerfile

## 简介

一般情况下，使用自动生成的默认 Dockerfile 需要遵守一定的规范才可以成功创建服务，模板如下：

	FROM baseImageUrl
	ADD compressed /srv/www

通过默认的 Dockerfile 创建服务约定条件如下：

* 不同的基础镜像
* 需要把所有发布的内容放在 compressed 目录下

以下是不同的语言所使用的基础镜像地址：

## Java
	hub.c.163.com/nce2/tomcat:or7_7.0.62
Tomcat (7.0.62)、JDK (1.7.0)

## PHP
	hub.c.163.com/nce2/php:5.5

## Node.js
	hub.c.163.com/nce2/nodejs:0.12.2
Node.js (0.12.2)

## Python
	hub.c.163.com/nce2/python:2.7
Python (2.7)

## Ruby
	hub.c.163.com/nce2/ruby:1.9.1
Ruby (1.9.1)、Rails (3.2)