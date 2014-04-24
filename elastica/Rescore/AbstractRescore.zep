namespace Elastica\Rescore;

/**
* @package Elastica
* @author Aris Kemper <aris.github@gmail.com>
* @link http://www.elasticsearch.org/guide/reference/api/search/rescore/
*/
abstract class AbstractRescore extends Param
{
    /**
    * Overriden to return rescore as name
    *
    * @return string name
    */
    protected function _getBaseName() -> string
    {
        return "rescore";
    }

    /**
    * Sets window_size
    *
    * @param int $size
    * @return \Elastica\Rescore
    */
    public function setWindowSize(size) -> <\Elastica\Rescore>
    {
        return $this->setParam("window_size", size);
    }
}