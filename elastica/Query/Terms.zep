namespace Elastica\Query;

/**
 * Terms query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/terms-query.html
 */
class Terms extends AbstractQuery
{
    /**
     * Terms
     *
     * @var array Terms
     */
    protected _terms = [];

    /**
     * Params
     *
     * @var array Params
     */
    protected _params = [];

    /**
     * Terms key
     *
     * @var string Terms key
     */
    protected _key = "";

    /**
     * Construct terms query
     *
     * @param string key   OPTIONAL Terms key
     * @param array  terms OPTIONAL Terms list
     */
    public function __construct(string key = "", array terms = []) -> void
    {
        this->setTerms(key, terms);
    }

    /**
     * Sets key and terms for the query
     *
     * @param  string                    key   Terms key
     * @param  array                     terms Terms for the query.
     * @return \Elastica\Query\Terms
     */
    public function setTerms(string key, array terms) -> <\Elastica\Query\Terms>
    {
        let this->_key = key;
        let this->_terms = array_values(terms);

        return this;
    }

    /**
     * Adds a single term to the list
     *
     * @param  string                    term Term
     * @return \Elastica\Query\Terms
     */
    public function addTerm(string term) -> <\Elastica\Query\Terms>
    {
        let this->_terms[] = term;

        return this;
    }

    /**
     * Sets the minimum matching values
     *
     * @param  int                       minimum Minimum value
     * @return \Elastica\Query\Terms
     */
    public function setMinimumMatch(int minimum) -> <\Elastica\Query\Terms>
    {
        return this->setParam("minimum_match", minimum);
    }

    /**
     * Converts the terms object to an array
     *
     * @see \Elastica\Query\AbstractQuery::toArray()
     * @throws \Elastica\Exception\InvalidException
     * @return array                               Query array
     */
    public function toArray() -> array
    {
        if empty this->_key {
            throw new \Elastica\Exception\InvalidException("Terms key has to be set");
        }
        this->setParam(this->_key, this->_terms);

        return parent::toArray();
    }
}