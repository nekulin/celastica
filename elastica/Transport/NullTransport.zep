namespace Elastica\Transport;

/**
 * Elastica Null Transport object
 *
 * @package Elastica
 * @author Aris Kemper <aris.kemper@gmail.com>
 */
class NullTransport extends AbstractTransport
{
    /**
     * Null transport.
     *
     * @param \Elastica\Request request
     * @param  array             params Hostname, port, path, ...
     * @return \Elastica\Response Response empty object
     */
    public function exec(<\Elastica\Request> request, array params) -> <\Elastica\Response>
    {
        var response;
        let response = [
                "took": 0,
                "timed_out": FALSE,
                "_shards": [
                    "total": 0,
                    "successful": 0,
                    "failed": 0
                ],
                "hits": [
                    "total": 0,
                    "max_score": NULL,
                    "hits": []
                ],
                "params": params
                );

         return new \Elastica\Response(json_encode(response));
    }
}