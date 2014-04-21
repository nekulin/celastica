namespace Elastica\Filter;

/**
 * Type Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/type-filter.html
 */
class Type extends AbstractFilter
{
    /**
     * Type name
     *
     * @var string
     */
    protected _type = null;

    /**
     * Construct Type Filter
     *
     * @param  string                     typeName Type name
     */
    public function __construct(string typeName = null)
    {
        if typeName {
            this->setType(typeName);
        }
    }

    /**
     * Ads a field with arguments to the range query
     *
     * @param  string                     typeName Type name
     * @return \Elastica\Filter\Type current object
     */
    public function setType(string typeName) -> <\Elastica\Filter\Type>
    {
        let this->_type = typeName;

        return this;
    }

    /**
     * Convert object to array
     *
     * @see \Elastica\Filter\AbstractFilter::toArray()
     * @return array Filter array
     */
    public function toArray() -> array
    {
        var data = [];
        let data["type"]["value"] = this->_type;
        return data;
    }
}