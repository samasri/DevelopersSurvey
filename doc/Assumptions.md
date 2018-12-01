* Database
	* Questions table, qtype column:
		* bg: background questions
		* sg: Survey questions
			* Since most of those questions are MC questions, the question_text is a string representation of an array with delimeter `||`.
			* If the represented array is of length = 1, then this is an open ended question.
			* Example: question_text="How much do you agree with that sentence? || Strongly agree || Agree". This is a representation of the question "How much do you agree with that sentence" with possible answers: "Strongly agree" and "Agree".
		* eg: exit questions
	* Sentences table: The dummy thread sentences are fixed of IDs -1 and -2
	* Questions Table: Background questions have sentence_id = -3
* In theads, right sidebar is 400 px (hard coded)