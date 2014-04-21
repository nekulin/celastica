namespace Elastica\Filter;

/**
 * Prefix filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/prefix-filter.html
 */
class Prefix extends AbstractFilter
{
    /**
     * Holds the name of the field for the prefix.
     *
     * @var string
     */
    protected _field = "";

    /**
     * Holds the prefix string.
     *
     * @var string
     */
    protected _prefix = "";

    /**
     * Creates prefix filter
     *
     * @param string field  Field name
     * @param string prefix Prefix string
     */
    public function __construct(string field = "", string prefix = "")
    {
        this->setField(field);
        this->setPrefix(prefix);
    }

    /**
     * Sets the name of the prefix field.
     *
     * @param  string                       field Field name
     * @return \Elastica\Filter\Prefix
     */
    public function setField(string field) -> <\Elastica\Filter\Prefix>
    {
        let this->_field = field;

        return this;
    }

    /**
     * Sets the prefix string.
     *
     * @param  string                       prefix Prefix string
     * @return \Elastica\Filter\Prefix
     */
    public function setPrefix(string prefix) -> <\Elastica\Filter\Prefix>
    {
        let this->_prefix = prefix;

        return this;
    }

    /**
     * Converts object to an array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @return array data array
     */
    public function toArray() -> array
    {
        this->setParam(this->_field, this->_prefix);

        return parent::toArray();
    }
}