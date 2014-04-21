namespace Elastica\Filter;

/**
 * Missing Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/missing-filter.html
 */
class Missing extends AbstractFilter
{
    /**
     * Construct missing filter
     *
     * @param string field OPTIONAL
     */
    public function __construct(string field = "")
    {
        if (strlen(field)) {
            this->setField(field);
        }
    }

    /**
     * Set field
     *
     * @param  string                        field
     * @return \Elastica\Filter\Missing
     */
    public function setField(string field) -> <\Elastica\Filter\Missing>
    {
        return this->setParam("field", (string) field);
    }
}