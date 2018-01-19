#!/usr/bin/python
import csv
from datetime import datetime
from elasticsearch import Elasticsearch
#es = Elasticsearch()
es = Elasticsearch(["el-1", "el-2","el-3"], sniff_on_start=True)
print(es.info())
z=0


with open('data.csv', 'rb') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
#        print row['date'],row['price']
	doc = {
	    'author': 'el.py',
	    'text': row['price'],
	    'timestamp': row['date'],
	}
	res = es.index(index="prices", doc_type="price", id=z, body=doc)
	print(res['result'])
	z+=1


#res = es.get(index="test-index", doc_type='tweet', id=1)
#print res
#print(res['_source'])

#es.indices.refresh(index="test-index")

#res = es.search(index="test-index", body={"query": {"match_all": {}}})
#print("Got %d Hits:" % res['hits']['total'])
#for hit in res['hits']['hits']:
#    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
