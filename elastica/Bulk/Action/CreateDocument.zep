namespace Elastica\Bulk\Action;

class CreateDocument extends IndexDocument
{
    /**
     * @var string
     */
    protected _opType = \Elastica\Bulk\Action::OP_TYPE_CREATE;
}