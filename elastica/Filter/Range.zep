namespace Elastica\Filter;

/**
 * Range Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/range-filter.html
 */
class Range extends AbstractFilter
{
    /**
     * Fields
     *
     * @var array Fields
     */
    protected _fields = [];

    /**
     * Construct range filter
     *
     * @param string|bool fieldName Field name
     * @param array       args      Field arguments
     */
    public function __construct(var fieldName = false, array args = []) -> void
    {
        if fieldName {
            this->addField(fieldName, args);
        }
    }

    /**
     * Ads a field with arguments to the range query
     *
     * @param  string                      fieldName Field name
     * @param  array                       args      Field arguments
     * @return \Elastica\Filter\Range
     */
    public function addField(string fieldName, array args) -> <\Elastica\Filter\Range>
    {
        let this->_fields[fieldName] = args;
        return this;
    }

    /**
     * Converts object to array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @return array Filter array
     */
    public function toArray() -> array
    {
        this->setParams(this->_fields);
        return parent::toArray();
    }
}