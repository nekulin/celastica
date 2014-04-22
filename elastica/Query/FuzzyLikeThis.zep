namespace Elastica\Query;

/**
 * Fuzzy Like This query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/flt-query.html
 */
class FuzzyLikeThis extends AbstractQuery
{
    protected _functions = [];
    /**
     * Field names
     *
     * @var array Field names
     */
    protected _fields = [];

    /**
     * Like text
     *
     * @var string Like text
     */
    protected _likeText   = "";

    /**
     * Ignore term frequency
     *
     * @var boolean ignore term frequency
     */
    protected _ignoreTF = false;

    /**
     * Max query terms value
     *
     * @var int Max query terms value
     */
    protected _maxQueryTerms = 25;

    /**
     * minimum similarity
     *
     * @var int minimum similarity
     */
    protected _minSimilarity = 0.5;

    /**
     * Prefix Length
     *
     * @var int Prefix Length
     */
    protected _prefixLength = 0;

    /**
     * Boost
     *
     * @var float Boost
     */
    protected _boost = 1.0;

    /**
     * Adds field to flt query
     *
     * @param  array                             fields Field names
     * @return \Elastica\Query\FuzzyLikeThis Current object
     */
    public function addFields(array fields) -> <\Elastica\Query\FuzzyLikeThis>
    {
        let this->_fields = fields;

        return this;
    }

    /**
     * Set the "like_text" value
     *
     * @param  string                            text
     * @return \Elastica\Query\FuzzyLikeThis This current object
     */
    public function setLikeText(string text) -> <\Elastica\Query\FuzzyLikeThi>
    {
        let text = trim(text);
        let this->_likeText = text;

        return this;
    }

    /**
     * Set the "ignore_tf" value (ignore term frequency)
     *
     * @param  bool                              ignoreTF
     * @return \Elastica\Query\FuzzyLikeThis Current object
     */
    public function setIgnoreTF(boolean ignoreTF) -> <\Elastica\Query\FuzzyLikeThis>
    {
        let this->_ignoreTF = ignoreTF;

        return this;
    }

    /**
     * Set the minimum similarity
     *
     * @param  int                               value
     * @return \Elastica\Query\FuzzyLikeThis This current object
     */
    public function setMinSimilarity(var value) -> <\Elastica\Query\FuzzyLikeThis>
    {
        let value = (float) value;
        let this->_minSimilarity = value;

        return this;
    }

    /**
     * Set boost
     *
     * @param  float                             value Boost value
     * @return \Elastica\Query\FuzzyLikeThis Query object
     */
    public function setBoost(var value)
    {
        let this->_boost = (float) value;

        return this;
    }

    /**
     * Set Prefix Length
     *
     * @param  int                               value Prefix length
     * @return \Elastica\Query\FuzzyLikeThis
     */
    public function setPrefixLength(int value) -> <\Elastica\Query\FuzzyLikeThis>
    {
        let this->_prefixLength = value;

        return this;
    }

    /**
     * Set max_query_terms
     *
     * @param  int                               value Max query terms value
     * @return \Elastica\Query\FuzzyLikeThis
     */
    public function setMaxQueryTerms(int value) -> <\Elastica\Query\FuzzyLikeThis>
    {
        let this->_maxQueryTerms = value;

        return this;
    }

    /**
     * Converts fuzzy like this query to array
     *
     * @return array Query array
     * @see \Elastica\Query\AbstractQuery::toArray()
     */
    public function toArray() -> array
    {
        var args = [], ret = [];

        if !empty this->_fields {
            let args["fields"] = this->_fields;
        }

        if !empty this->_boost {
            let args["boost"] = this->_boost;
        }

        if !empty this->_likeText {
            let args["like_text"] = this->_likeText;
        }

        let args["min_similarity"] = (this->_minSimilarity > 0) ? this->_minSimilarity : 0;

        let args["prefix_length"]   = this->_prefixLength;
        let args["ignore_tf"] = this->_ignoreTF;
        let args["max_query_terms"] = this->_maxQueryTerms;

        let ret["fuzzy_like_this"] = args;
        return ret;
    }
}