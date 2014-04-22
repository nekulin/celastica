namespace Elastica\Query;

/**
 * More Like This query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/mlt-query.html
 */
class MoreLikeThis extends AbstractQuery
{
    /**
     * Adds field to mlt query
     *
     * @param  array                            fields Field names
     * @return \Elastica\Query\MoreLikeThis Current object
     */
    public function setFields(array fields) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("fields", fields);
    }

    /**
     * Set the "like_text" value
     *
     * @param  string                           likeText
     * @return \Elastica\Query\MoreLikeThis This current object
     */
    public function setLikeText(string likeText) -> <\Elastica\Query\MoreLikeThis>
    {
        let likeText = trim(likeText);

        return this->setParam("like_text", likeText);
    }

    /**
     * Set boost
     *
     * @param  float                            boost Boost value
     * @return \Elastica\Query\MoreLikeThis Query object
     */
    public function setBoost(var boost) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("boost", (float) boost);
    }

    /**
     * Set max_query_terms
     *
     * @param  int                              maxQueryTerms Max query terms value
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMaxQueryTerms(int maxQueryTerms) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("max_query_terms", maxQueryTerms);
    }

    /**
     * Set percent terms to match
     *
     * @param  float                            percentTermsToMatch Percentage
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setPercentTermsToMatch(var percentTermsToMatch) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("percent_terms_to_match", (float) percentTermsToMatch);
    }

    /**
     * Set min term frequency
     *
     * @param  int                              minTermFreq
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMinTermFrequency(int minTermFreq) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("min_term_freq", minTermFreq);
    }

    /**
     * set min document frequency
     *
     * @param  int                              minDocFreq
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMinDocFrequency(int minDocFreq) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("min_doc_freq", minDocFreq);
    }

    /**
     * set max document frequency
     *
     * @param  int                              maxDocFreq
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMaxDocFrequency(int maxDocFreq) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("max_doc_freq", maxDocFreq);
    }

    /**
     * Set min word length
     *
     * @param  int                              minWordLength
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMinWordLength(int minWordLength) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("min_word_length", minWordLength);
    }

    /**
     * Set max word length
     *
     * @param  int                              maxWordLength
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setMaxWordLength(int maxWordLength) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("max_word_length", maxWordLength);
    }

    /**
     * Set boost terms
     *
     * @param  bool                             boostTerms
     * @return \Elastica\Query\MoreLikeThis
     * @link http://www.elasticsearch.org/guide/reference/query-dsl/mlt-query.html
     */
    public function setBoostTerms(boolean boostTerms) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("boost_terms", boostTerms);
    }

    /**
     * Set analyzer
     *
     * @param  string                           analyzer
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setAnalyzer(string analyzer) -> <\Elastica\Query\MoreLikeThis>
    {
        let analyzer = trim(analyzer);

        return this->setParam("analyzer", analyzer);
    }

    /**
     * Set stop words
     *
     * @param  array                            stopWords
     * @return \Elastica\Query\MoreLikeThis
     */
    public function setStopWords(array stopWords) -> <\Elastica\Query\MoreLikeThis>
    {
        return this->setParam("stop_words", stopWords);
    }
}