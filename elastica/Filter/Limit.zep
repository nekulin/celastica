namespace Elastica\Filter;

/**
 * Limit Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/limit-filter.html
 */
class Limit extends AbstractFilter
{
    /**
     * Construct limit filter
     *
     * @param  int limit Limit
     */
    public function __construct(int limit)
    {
        this->setLimit(limit);
    }

    /**
     * Set the limit
     *
     * @param  int                         limit Limit
     * @return \Elastica\Filter\Limit
     */
    public function setLimit(int limit) -> <\Elastica\Filter\Limit>
    {
        return this->setParam("value", limit);
    }
}