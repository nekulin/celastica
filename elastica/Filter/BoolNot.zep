namespace Elastica\Filter;

/**
 * Not Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/not-filter.html
 */
class BoolNot extends AbstractFilter
{
    /**
     * Creates Not filter query
     *
     * @param \Elastica\Filter\AbstractFilter filter Filter object
     */
    public function __construct(<\Elastica\Filter\AbstractFilter> filter) -> void
    {
        this->setFilter(filter);
    }

    /**
     * Set filter
     *
     * @param  \Elastica\Filter\AbstractFilter filter
     * @return \Elastica\Filter\BoolNot
     */
    public function setFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Filter\BoolNot>
    {
        return this->setParam("filter", filter->toArray());
    }

    /**
     * @return string
     */
    protected function _getBaseName() -> string
    {
        return "not";
    }
}