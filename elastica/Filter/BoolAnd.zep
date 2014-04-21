namespace Elastica\Filter;

/**
 * And Filter
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 * @link http://www.elasticsearch.org/guide/reference/query-dsl/and-filter.html
 */
class BoolAnd extends AbstractMulti
{
    /**
     * @return string
     */
    protected function _getBaseName() -> string
    {
        return "and";
    }
}