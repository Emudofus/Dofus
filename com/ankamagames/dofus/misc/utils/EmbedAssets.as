package com.ankamagames.dofus.misc.utils
{
    import flash.display.*;
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

        public function EmbedAssets()
        {
            return;
        }// end function

        public static function getBitmap(param1:String, param2:Boolean = true) : Bitmap
        {
            var _loc_3:* = EmbedAssets[param1] as Class;
            var _loc_4:* = new _loc_3 as Bitmap;
            return new _loc_3 as Bitmap;
        }// end function

        public static function getSprite(param1:String, param2:Boolean = true) : Sprite
        {
            var _loc_3:* = EmbedAssets[param1] as Class;
            var _loc_4:* = new _loc_3 as Sprite;
            return new _loc_3 as Sprite;
        }// end function

        private static function saveCache(param1:String, param2) : void
        {
            _cache[param1] = param2;
            return;
        }// end function

    }
}
