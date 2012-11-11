package com.ankamagames.jerakine.utils.misc
{
    import flash.system.*;

    public class ApplicationDomainShareManager extends Object
    {
        private static var _applicationDomain:ApplicationDomain;

        public function ApplicationDomainShareManager()
        {
            return;
        }// end function

        public static function set currentApplicationDomain(param1:ApplicationDomain) : void
        {
            _applicationDomain = param1;
            return;
        }// end function

        public static function get currentApplicationDomain() : ApplicationDomain
        {
            return _applicationDomain;
        }// end function

    }
}
