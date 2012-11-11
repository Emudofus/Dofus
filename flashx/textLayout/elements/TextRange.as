package flashx.textLayout.elements
{

    public class TextRange extends Object
    {
        private var _textFlow:TextFlow;
        private var _anchorPosition:int;
        private var _activePosition:int;

        public function TextRange(param1:TextFlow, param2:int, param3:int)
        {
            this._textFlow = param1;
            if (param2 != -1 || param3 != -1)
            {
                param2 = this.clampToRange(param2);
                param3 = this.clampToRange(param3);
            }
            this._anchorPosition = param2;
            this._activePosition = param3;
            return;
        }// end function

        private function clampToRange(param1:int) : int
        {
            if (param1 < 0)
            {
                return 0;
            }
            if (param1 > this._textFlow.textLength)
            {
                return this._textFlow.textLength;
            }
            return param1;
        }// end function

        public function updateRange(param1:int, param2:int) : Boolean
        {
            if (param1 != -1 || param2 != -1)
            {
                param1 = this.clampToRange(param1);
                param2 = this.clampToRange(param2);
            }
            if (this._anchorPosition != param1 || this._activePosition != param2)
            {
                this._anchorPosition = param1;
                this._activePosition = param2;
                return true;
            }
            return false;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function set textFlow(param1:TextFlow) : void
        {
            this._textFlow = param1;
            return;
        }// end function

        public function get anchorPosition() : int
        {
            return this._anchorPosition;
        }// end function

        public function set anchorPosition(param1:int) : void
        {
            this._anchorPosition = param1;
            return;
        }// end function

        public function get activePosition() : int
        {
            return this._activePosition;
        }// end function

        public function set activePosition(param1:int) : void
        {
            this._activePosition = param1;
            return;
        }// end function

        public function get absoluteStart() : int
        {
            return this._activePosition < this._anchorPosition ? (this._activePosition) : (this._anchorPosition);
        }// end function

        public function set absoluteStart(param1:int) : void
        {
            if (this._activePosition < this._anchorPosition)
            {
                this._activePosition = param1;
            }
            else
            {
                this._anchorPosition = param1;
            }
            return;
        }// end function

        public function get absoluteEnd() : int
        {
            return this._activePosition > this._anchorPosition ? (this._activePosition) : (this._anchorPosition);
        }// end function

        public function set absoluteEnd(param1:int) : void
        {
            if (this._activePosition > this._anchorPosition)
            {
                this._activePosition = param1;
            }
            else
            {
                this._anchorPosition = param1;
            }
            return;
        }// end function

    }
}
