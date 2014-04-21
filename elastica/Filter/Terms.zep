namespace Elastica\Filter;

/**
 * Terms filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/terms-filter.html
 */
class Terms extends AbstractFilter
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
     * Creates terms filter
     *
     * @param string key   Terms key
     * @param array  terms Terms values
     */
    public function __construct(string key = "", array terms = [])
    {
        this->setTerms(key, terms);
    }

    /**
     * Sets key and terms for the filter
     *
     * @param  string                      key   Terms key
     * @param  array                       terms Terms for the query.
     * @return \Elastica\Filter\Terms
     */
    public function setTerms(string key, array terms) -> <\Elastica\Filter\Terms>
    {
        let this->_key = key;
        let this->_terms = array_values(terms);

        return this;
    }

    /**
     * Set the lookup parameters for this filter
     * @param string key terms key
     * @param string|\Elastica\Type type document type from which to fetch the terms values
     * @param string id id of the document from which to fetch the terms values
     * @param string path the field from which to fetch the values for the filter
     * @param string|\Elastica\Index index the index from which to fetch the terms values. Defaults to the current index.
     * @return \Elastica\Filter\Terms Filter object
     */
    public function setLookup(
        string key,
        var type,
        string id,
        string path,
        var index = NULL
        ) -> <\Elastica\Filter\Terms>
    {
        let this->_key = key;
        if type instanceof \Elastica\Type {
            let type = type->getName();
        }
        let this->_terms = [
            "type": type,
            "id": id,
            "path": path
        ];
        if index != null {
            if index instanceof \Elastica\Index {
                let index = index->getName();
            }
            let this->_terms["index"] = index;
        }
        return this;
    }

    /**
     * Adds an additional term to the query
     *
     * @param  string                      term Filter term
     * @return \Elastica\Filter\Terms Filter object
     */
    public function addTerm(string term) -> <\Elastica\Filter\Terms>
    {
        let this->_terms[] = term;

        return this;
    }

    /**
     * Converts object to an array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @throws \Elastica\Exception\InvalidException
     * @return array                               data array
     */
    public function toArray() -> array
    {
        if empty this->_key {
            throw new \Elastica\Exception\InvalidException("Terms key has to be set");
        }
        let this->_params[this->_key] = this->_terms;

        return ["terms": this->_params];
    }
}