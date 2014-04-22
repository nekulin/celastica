namespace Elastica\Query;

/**
 * Range query
 *
 * @package Elastica
 * @author Aris Kemper <spam@ruflin.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/range-query.html
 */
class Range extends AbstractQuery
{
    /**
     * Constructor
     *
     * @param string fieldName Field name
     * @param array  args      Field arguments
     */
    public function __construct(string fieldName = null, array args = [])
    {
        if fieldName {
            this->addField(fieldName, args);
        }
    }

    /**
     * Adds a range field to the query
     *
     * @param  string                    fieldName Field name
     * @param  array                     args      Field arguments
     * @return \Elastica\Query\Range Current object
     */
    public function addField(string fieldName, array args) -> <\Elastica\Query\Range>
    {
        return this->setParam(fieldName, args);
    }
}