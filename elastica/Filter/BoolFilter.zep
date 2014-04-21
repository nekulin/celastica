namespace Elastica\Filter;

/**
 * Bool Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/bool-query.html
 */
class BoolFilter extends AbstractFilter
{
    /**
     * @var float
     */
    protected _boost = 1.0;

    /**
     * Must
     *
     * @var array
     */
    protected _must = [];

    /**
     * Should
     *
     * @var array
     */
    protected _should = [];

    /**
     * Must not
     *
     * @var array
     */
    protected _mustNot = [];

    /**
     * Adds should filter
     *
     * @param  array|\Elastica\Filter\AbstractFilter args Filter data
     * @return \Elastica\Filter\Bool           Current object
     */
    public function addShould(var args) -> <\Elastica\Filter\BoolFilter>
    {
        return this->_addFilter("should", args);
    }

    /**
     * Adds must filter
     *
     * @param  array|\Elastica\Filter\AbstractFilter args Filter data
     * @return \Elastica\Filter\Bool           Current object
     */
    public function addMust(var args) -> <\Elastica\Filter\BoolFilter>
    {
        return this->_addFilter("must", args);
    }

    /**
     * Adds mustNot filter
     *
     * @param  array|\Elastica\Filter\AbstractFilter args Filter data
     * @return \Elastica\Filter\Bool           Current object
     */
    public function addMustNot(var args) -> <\Elastica\Filter\BoolFilter>
    {
        return this->_addFilter("mustNot", args);
    }

    /**
     * Adds general filter based on type
     *
     * @param  string                               type Filter type
     * @param  array|\Elastica\Filter\AbstractFilter args Filter data
     * @throws \Elastica\Exception\InvalidException
     * @return \Elastica\Filter\Bool           Current object
     */
    protected function _addFilter(string type, var args) -> <\Elastica\Filter\BoolFilter>
    {
        var varName;

        if args instanceof \Elastica\Filter\AbstractFilter {
            let args = args->toArray();
        }

        if !is_array(args) {
            throw new \Elastica\Exception\InvalidException("Invalid parameter. Has to be array or instance of Elastica\Filter");
        }

        let varName = "_" . type;
        //todo
        //let this->{varName}[] = args;

        return this;
    }

    /**
     * Converts bool filter to array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @return array Filter array
     */
    public function toArray() -> array
    {
        var args;
        let args = [];

        if !empty(this->_must) {
            let args["bool"]["must"] = this->_must;
        }

        if !empty(this->_should) {
            let args["bool"]["should"] = this->_should;
        }

        if !empty(this->_mustNot) {
            let args["bool"]["must_not"] = this->_mustNot;
        }

        return args;
    }

    /**
     * Sets the boost value for this filter
     *
     * @param  float                      boost Boost
     * @return \Elastica\Filter\Bool Current object
     */
    public function setBoost(var boost) -> <\Elastica\Filter\BoolFilter>
    {
        let this->_boost = boost;
        return this;
    }

}