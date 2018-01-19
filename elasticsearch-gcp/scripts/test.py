#!/usr/bin/python
import csv
import time
import datetime
from elasticsearch import Elasticsearch
#es = Elasticsearch()

s = "2016-12-01"
print time.mktime(datetime.datetime.strptime(s, "%Y-%m-%d").timetuple())
print datetime.datetime.now()

#res = es.get(index="test-index", doc_type='tweet', id=1)
#print res
#print(res['_source'])

#es.indices.refresh(index="test-index")

#res = es.search(index="test-index", body={"query": {"match_all": {}}})
#print("Got %d Hits:" % res['hits']['total'])
#for hit in res['hits']['hits']:
#    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
