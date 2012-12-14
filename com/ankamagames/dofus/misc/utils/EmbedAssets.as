package com.ankamagames.dofus.misc.utils
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class EmbedAssets extends Object
    {
        private static var _cache:Dictionary = new Dictionary();
        public static const DefaultBeriliaSlotIcon:Class = EmbedAssets_DefaultBeriliaSlotIcon;
        public static const CHECKPOINT_CLIP_TOP:Class = EmbedAssets_CHECKPOINT_CLIP_TOP;
        public static const CHECKPOINT_CLIP_LEFT:Class = EmbedAssets_CHECKPOINT_CLIP_LEFT;
        public static const CHECKPOINT_CLIP_BOTTOM:Class = EmbedAssets_CHECKPOINT_CLIP_BOTTOM;
        public static const CHECKPOINT_CLIP_RIGHT:Class = EmbedAssets_CHECKPOINT_CLIP_RIGHT;
        private static const CHECKPOINT_CLIP:Class = EmbedAssets_CHECKPOINT_CLIP;
        private static const QUEST_CLIP:Class = EmbedAssets_QUEST_CLIP;
        private static const QUEST_REPEATABLE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_CLIP;
        private static const QUEST_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_OBJECTIVE_CLIP;
        private static const QUEST_REPEATABLE_OBJECTIVE_CLIP:Class = EmbedAssets_QUEST_REPEATABLE_OBJECTIVE_CLIP;
        private static const TEAM_CIRCLE_CLIP:Class = EmbedAssets_TEAM_CIRCLE_CLIP;
        private static const SWORDS_CLIP:Class = EmbedAssets_SWORDS_CLIP;
        private static var matrix:Matrix = new Matrix();

        public function EmbedAssets()
        {
            return;
        }// end function

        public static function getBitmap(param1:String, param2:Boolean = false, param3:Boolean = true) : Bitmap
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            if (param3 && _cache[param1] != null)
            {
                _loc_4 = _cache[param1];
                if (!param2)
                {
                    return _loc_4;
                }
                _loc_6 = new BitmapData(_loc_4.width, _loc_4.height, true, 16711935);
                _loc_6.draw(_loc_4, matrix);
                return new Bitmap(_loc_6);
            }
            var _loc_5:* = EmbedAssets[param1] as Class;
            _loc_4 = new (EmbedAssets[param1] as Class)() as Bitmap;
            if (param3)
            {
                saveCache(param1, _loc_4);
            }
            return _loc_4;
        }// end function

        public static function getSprite(param1:String) : Sprite
        {
            var _loc_2:* = EmbedAssets[param1] as Class;
            var _loc_3:* = new _loc_2 as Sprite;
            return _loc_3;
        }// end function

        private static function saveCache(param1:String, param2) : void
        {
            _cache[param1] = param2;
            return;
        }// end function

    }
}
