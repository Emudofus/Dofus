package com.ankamagames.dofus.logic.game.roleplay.types
{
    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.components.Texture;
    import com.ankamagames.jerakine.types.Uri;
    import flash.events.Event;

    public class EntityIcon extends Sprite 
    {

        private var _icons:Dictionary;
        private var _nbIcons:int;
        public var needUpdate:Boolean;
        public var rendering:Boolean;

        public function EntityIcon()
        {
            this._icons = new Dictionary(true);
            mouseEnabled = (mouseChildren = false);
        }

        public function addIcon(pIconUri:String, pIconName:String):void
        {
            this._icons[pIconName] = new Texture();
            var icon:Texture = this._icons[pIconName];
            icon.uri = new Uri(pIconUri);
            icon.dispatchMessages = true;
            icon.addEventListener(Event.COMPLETE, this.iconRendered);
            icon.finalize();
            this._nbIcons++;
        }

        public function removeIcon(pIconName:String):void
        {
            var icon:Texture = this._icons[pIconName];
            if (icon)
            {
                if (icon.parent == this)
                {
                    removeChild(icon);
                };
                delete this._icons[pIconName];
                this._nbIcons--;
                if (numChildren == this._nbIcons)
                {
                    for each (icon in this._icons)
                    {
                        removeChild(icon);
                    };
                    for each (icon in this._icons)
                    {
                        icon.x = (((width == 0)) ? (icon.width / 2) : ((width + 5) + (icon.width / 2)));
                        addChild(icon);
                    };
                    this.needUpdate = true;
                };
            };
        }

        public function hasIcon(pIconName:String):Boolean
        {
            return (this._icons[pIconName]);
        }

        public function get length():int
        {
            return (this._nbIcons);
        }

        public function remove():void
        {
            if (parent)
            {
                parent.removeChild(this);
            };
        }

        private function iconRendered(pEvent:Event):void
        {
            var icon:Texture = (pEvent.currentTarget as Texture);
            icon.removeEventListener(Event.COMPLETE, this.iconRendered);
            icon.x = (((width == 0)) ? (icon.width / 2) : ((width + 5) + (icon.width / 2)));
            addChild(icon);
            this.needUpdate = true;
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.types

