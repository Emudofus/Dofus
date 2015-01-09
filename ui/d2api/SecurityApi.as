package d2api
{
    public class SecurityApi 
    {


        [Trusted]
        public function askSecureModeCode(callback:Function):void
        {
        }

        [Trusted]
        public function sendSecureModeCode(code:String, callback:Function, computerName:String=null):void
        {
        }

        [Trusted]
        public function SecureModeisActive():Boolean
        {
            return (false);
        }

        [Trusted]
        public function setShieldLevel(level:uint):void
        {
        }

        [Trusted]
        public function getShieldLevel():uint
        {
            return (0);
        }


    }
}//package d2api

