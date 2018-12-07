# Converts the CSV file to Ruby commands. Built for Python 2.7

import csv

with open('sampleData.csv', 'rb') as f:
	reader = csv.reader(f)
	for row in reader:
		technique = row[0]
		threadID = row[1]
		answerID = 'answer-' + row[2]
		paragraphIndex = row[3]
		sentenceIndex = row[4]
		sentenceText = row[5]
		originalSentenceText = row[6]
		
		print 'Sentence.create(thread_id: "{0}", answer_id: "{1}", sentence_text: "{2}", technique: "{3}")'.format(threadID, answerID, sentenceText, technique)
				