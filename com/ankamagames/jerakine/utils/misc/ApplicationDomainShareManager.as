package com.ankamagames.jerakine.utils.misc
{
    import flash.system.ApplicationDomain;

    public class ApplicationDomainShareManager 
    {

        private static var _applicationDomain:ApplicationDomain;


        public static function set currentApplicationDomain(a:ApplicationDomain):void
        {
            _applicationDomain = a;
        }

        public static function get currentApplicationDomain():ApplicationDomain
        {
            return (_applicationDomain);
        }


    }
}//package com.ankamagames.jerakine.utils.misc

