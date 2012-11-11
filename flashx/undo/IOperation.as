package flashx.undo
{

    public interface IOperation
    {

        public function IOperation();

        function performRedo() : void;

        function performUndo() : void;

    }
}
