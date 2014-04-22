namespace Elastica\Query;

/**
 * Term query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/term-query.html
 */
class Term extends AbstractQuery
{
    /**
     * Constructs the Term query object
     *
     * @param array term OPTIONAL Calls setTerm with the given term array
     */
    public function __construct(array term = [])
    {
        this->setRawTerm(term);
    }

    /**
     * Set term can be used instead of addTerm if some more special
     * values for a term have to be set.
     *
     * @param  array                    term Term array
     * @return \Elastica\Query\Term Current object
     */
    public function setRawTerm(array term) -> <\Elastica\Query\Term>
    {
        return this->setParams(term);
    }

    /**
     * Adds a term to the term query
     *
     * @param  string                   key   Key to query
     * @param  string|array             value Values(s) for the query. Boost can be set with array
     * @param  float                    boost OPTIONAL Boost value (default = 1.0)
     * @return \Elastica\Query\Term Current object
     */
    public function setTerm(string key, var value, var boost = 1.0) -> <\Elastica\Query\Term>
    {
        var data = [];
        let data[key]["value"] = value;
        let data[key]["boost"] = boost;
        return this->setRawTerm(data);
    }
}