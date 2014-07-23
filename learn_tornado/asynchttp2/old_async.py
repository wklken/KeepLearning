#!/usr/bin/env python
# encoding: utf-8

def get(self):
    client = AsyncHTTPClient()
    client.fetch("http://example.com", callback=on_response)

def on_response(self, response):
    client = AsyncHTTPClient()
    client.fetch("http://another.example.com/", callback=on_response2)

def on_response2(self, response):
    client = AsyncHTTPClient()
    client.fetch("http://still.another.example.com/", callback=on_response3)

def on_response3(self, response):
    [etc., etc.]
