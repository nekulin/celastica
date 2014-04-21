namespace Elastica\Filter;

/**
 * Multi Abstract filter object. Should be extended by filter types composed of an array of sub filters
 *
 * @package Elastica
 * @author Nicolas Ruflin <spam@ruflin.com>
 */
abstract class AbstractMulti extends AbstractFilter
{
    /**
     * Filters
     * @var array
     */
    protected _filters = [];

    /**
     * Add filter
     *
     * @param  \Elastica\Filter\AbstractFilter      filter
     * @return \Elastica\Filter\AbstractMulti
     */
    public function addFilter(<\Elastica\Filter\AbstractFilter> filter) -> <\Elastica\Filter\AbstractMulti>
    {
        let this->_filters[] = filter->toArray();
        return this;
    }

    /**
     * Set filters
     *
     * @param  array                               filters
     * @return \Elastica\Filter\AbstractMulti
     */
    public function setFilters(array filters) -> <\Elastica\Filter\AbstractMulti>
    {
        var filter;
        let this->_filters = [];
        for filter in filters {
            this->addFilter(filter);
        }

        return this;
    }

    /**
     * @return array Filters
     */
    public function getFilters() -> array
    {
        return this->_filters;
    }

    /**
     * @see \Elastica\Param::toArray()
     */
    public function toArray() -> array
    {
        var data, name, filterData;

        let data = parent::toArray();
        let name = this->_getBaseName();
        let filterData = data[name];

        if empty filterData {
            let filterData = this->_filters;
        } else {
            let filterData["filters"] = this->_filters;
        }

        let data[name] = filterData;

        return data;
    }
}