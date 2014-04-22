namespace Elastica\Suggest;


/**
 * Class Term
 * @package Elastica\Suggest
 * @link http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-suggesters-term.html
 */
class Term extends AbstractSuggest
{
    const SORT_SCORE = "score";
    const SORT_FREQUENCY = "frequency";

    const SUGGEST_MODE_MISSING = "missing";
    const SUGGEST_MODE_POPULAR = "popular";
    const SUGGEST_MODE_ALWAYS = "always";

    /**
     * @param string analyzer
     * @return \Elastica\Suggest\Term
     */
    public function setAnalyzer(string analyzer) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("analyzer", analyzer);
    }

    /**
     * @param string sort see SORT_* constants for options
     * @return \Elastica\Suggest\Term
     */
    public function setSort(string sort) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("sort", sort);
    }

    /**
     * @param string mode see SUGGEST_MODE_* constants for options
     * @return \Elastica\Suggest\Term
     */
    public function setSuggestMode(string mode) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("suggest_mode", mode);
    }

    /**
     * If true, suggest terms will be lower cased after text analysis
     * @param bool lowercase
     * @return \Elastica\Suggest\Term
     */
    public function setLowercaseTerms(boolean lowercase = true) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("lowercase_terms", lowercase);
    }

    /**
     * Set the maximum edit distance candidate suggestions can have in order to be considered as a suggestion
     * @param int max Either 1 or 2. Any other value will result in an error.
     * @return \Elastica\Suggest\Term
     */
    public function setMaxEdits(int max) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("max_edits", max);
    }

    /**
     * The number of minimum prefix characters that must match in order to be a suggestion candidate
     * @param int length Defaults to 1.
     * @return \Elastica\Suggest\Term
     */
    public function setPrefixLength(int length) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("prefix_len", length);
    }

    /**
     * The minimum length a suggest text term must have in order to be included.
     * @param int length Defaults to 4.
     * @return \Elastica\Suggest\Term
     */
    public function setMinWordLength(int length) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("min_word_len", length);
    }

    /**
     * @param int max Defaults to 5.
     * @return \Elastica\Suggest\Term
     */
    public function setMaxInspections(int max) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("max_inspections", max);
    }

    /**
     * Set the minimum number of documents in which a suggestion should appear
     * @param int|float min Defaults to 0. If the value is greater than 1, it must be a whole number.
     * @return \Elastica\Suggest\Term
     */
    public function setMinDocFrequency(var min) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("min_doc_freq", min);
    }

    /**
     * Set the maximum number of documents in which a suggest text token can exist in order to be included
     * @param float max
     * @return \Elastica\Suggest\Term
     */
    public function setMaxTermFrequency(var max) -> <\Elastica\Suggest\Term>
    {
        return this->setParam("max_term_freq", max);
    }
}