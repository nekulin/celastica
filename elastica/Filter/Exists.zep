namespace Elastica\Filter;

/**
 * Exists query
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/exists-filter.html
 */
class Exists extends AbstractFilter
{
    /**
     * Construct exists filter
     *
     * @param string field
     */
    public function __construct(string field) -> void
    {
        this->setField(field);
    }

    /**
     * Set field
     *
     * @param  string                       field
     * @return \Elastica\Filter\Exists
     */
    public function setField(string field) -> <\Elastica\Filter\Exists>
    {
        return this->setParam("field", field);
    }
}