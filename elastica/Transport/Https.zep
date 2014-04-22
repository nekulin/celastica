namespace Elastica\Transport;

/**
 * Elastica Http Transport object
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class Https extends Http
{
    /**
     * Https scheme
     *
     * @var string https scheme
     */
    protected _scheme = "https";

    /**
     * Overloads setupCurl to set SSL params
     *
     * @param resource connection Curl connection resource
     */
    protected function _setupCurl(connection)
    {
        parent::_setupCurl(connection);
    }
}