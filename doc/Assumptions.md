* Database
	* Questions table
		* qtype column:
			* bg: background questions
			* sg: Survey questions
				* Since most of those questions are MC questions, the question_text is a string representation of an array with delimeter `||`.
				* If the represented array is of length = 1, then this is an open ended question.
				* Example: question_text="How much do you agree with that sentence? || Strongly agree || Agree". This is a representation of the question "How much do you agree with that sentence" with possible answers: "Strongly agree" and "Agree".
			* eg: exit questions
			* lg: question that should be displayed at the end of each thread
		* responseType column: if the value is 'text' (case sensitive), the text box for that question will appear bigger in the view forms. Other values are not handled in the code.
		* Background questions have sentence_id = -3
	* Sentences table:
		* The dummy thread sentences are fixed of IDs -1 and -2
		* The sentence with ID = -3 is used for responses of background questions. Since each response should be linked to a sentence ID but responses for background questions are not related to any thread or response. Hence, a sentence with ID = -3 is created, as a null sentence, to allow such responses to be recorded.
		* Since there are questions that are not related to any questions but are related to the thread, each thread also has a "dummy sentence", which has the sentence_text = -1 and answer_id = -1. Those sentences are used to allow responses of non-sentence-related questions (but thread-related questions) to be recorded.
* In theads, right sidebar is 400 px (hard coded)
* The null sentence ID is hard coded to -3 in multiple places in the code.