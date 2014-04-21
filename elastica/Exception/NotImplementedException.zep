namespace Elastica\Exception;

/**
 * Not implemented exception
 *
 * Is thrown if a function or feature is not implemented yet
 *
 * @package Elastica
 * @author Aris Kemper <aris.github@gmail.com>
 */
class NotImplementedException extends \BadMethodCallException implements ExceptionInterface
{
}