package d2api
{
    import d2network.GameContextActorInformations;

    public class UtilApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function callWithParameters(method:Function, parameters:Object):void
        {
        }

        [Untrusted]
        public function callConstructorWithParameters(callClass:Class, parameters:Object)
        {
            return (null);
        }

        [Untrusted]
        public function callRWithParameters(method:Function, parameters:Object)
        {
            return (null);
        }

        [Untrusted]
        public function kamasToString(kamas:Number, unit:String="-"):String
        {
            return (null);
        }

        [Untrusted]
        public function formateIntToString(val:Number):String
        {
            return (null);
        }

        [Untrusted]
        public function stringToKamas(string:String, unit:String="-"):int
        {
            return (0);
        }

        [Untrusted]
        public function getTextWithParams(textId:int, params:Object, replace:String="%"):String
        {
            return (null);
        }

        [Untrusted]
        public function applyTextParams(pText:String, pParams:Object, pReplace:String="%"):String
        {
            return (null);
        }

        [Trusted]
        public function noAccent(str:String):String
        {
            return (null);
        }

        [Untrusted]
        public function changeColor(obj:Object, color:Number, depth:int, unColor:Boolean=false):void
        {
        }

        [Untrusted]
        public function sortOnString(list:*, field:String=""):void
        {
        }

        [Untrusted]
        public function sort(target:*, field:String, ascendand:Boolean=true, isNumeric:Boolean=false)
        {
            return (null);
        }

        [Untrusted]
        public function filter(target:*, pattern:*, field:String)
        {
            return (null);
        }

        [Untrusted]
        public function getTiphonEntityLook(pEntityId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getRealTiphonEntityLook(pEntityId:int, pWithoutMount:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function getLookFromContext(pEntityId:int, pForceCreature:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function getLookFromContextInfos(pInfos:GameContextActorInformations, pForceCreature:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function isCreature(pEntityId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isCreatureFromLook(pLook:Object):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isIncarnation(pEntityId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isIncarnationFromLook(pLook:Object):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function isCreatureMode():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getCreatureLook(pEntityId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSecureObjectIndex(pTab:*, pSecureObj:*):int
        {
            return (0);
        }


    }
}//package d2api

