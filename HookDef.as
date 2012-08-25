package 
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;

    class HookDef extends Object
    {
        private var _hook:Hook;
        private var _args:Array;

        function HookDef(param1:Hook, param2:Array)
        {
            this._hook = param1;
            this._args = param2;
            return;
        }// end function

        public function get hook() : Hook
        {
            return this._hook;
        }// end function

        public function get args() : Array
        {
            return this._args;
        }// end function

        public function isEqual(param1:HookDef) : Boolean
        {
            if (this.hook != param1.hook)
            {
                return false;
            }
            if (this.args.length != param1.args.length)
            {
                return false;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this.args.length)
            {
                
                if (this.args[_loc_2] != param1.args[_loc_2])
                {
                    return false;
                }
                _loc_2++;
            }
            return true;
        }// end function

        public function run() : void
        {
            switch(this.args.length)
            {
                case 0:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook);
                    break;
                }
                case 1:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0]);
                    break;
                }
                case 2:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1]);
                    break;
                }
                case 3:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2]);
                    break;
                }
                case 4:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3]);
                    break;
                }
                case 5:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4]);
                    break;
                }
                case 6:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5]);
                    break;
                }
                case 7:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6]);
                    break;
                }
                case 8:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6], this.args[7]);
                    break;
                }
                case 9:
                {
                    KernelEventsManager.getInstance().processCallback(this.hook, this.args[0], this.args[1], this.args[2], this.args[3], this.args[4], this.args[5], this.args[6], this.args[7], this.args[8]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
