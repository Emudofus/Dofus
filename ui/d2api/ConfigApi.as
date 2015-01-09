package d2api
{
    public class ConfigApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getConfigProperty(configModuleName:String, propertyName:String)
        {
            return (null);
        }

        [Untrusted]
        public function setConfigProperty(configModuleName:String, propertyName:String, value:*):void
        {
        }

        [Untrusted]
        public function resetConfigProperty(configModuleName:String, propertyName:String):void
        {
        }

        [Untrusted]
        public function createOptionManager(name:String):Object
        {
            return (null);
        }

        [Trusted]
        public function getAllThemes():Object
        {
            return (null);
        }

        [Untrusted]
        public function getCurrentTheme():String
        {
            return (null);
        }

        [Trusted]
        public function isOptionalFeatureActive(id:int):Boolean
        {
            return (false);
        }

        [Trusted]
        public function getServerConstant(id:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getExternalNotificationOptions(pNotificationType:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function setExternalNotificationOptions(pNotificationType:int, pOptions:Object):void
        {
        }

        [Untrusted]
        public function setDebugMode(activate:Boolean):void
        {
        }

        [Untrusted]
        public function getDebugMode():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function debugFileExists():Boolean
        {
            return (false);
        }


    }
}//package d2api

