package com.ankamagames.dofus.logic.game.common.types
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.types.enums.DofusShopEnum;

    public class DofusShopHighlight extends DofusShopObject implements IDataCenter 
    {

        private var _type:String;
        private var _mode:String;
        private var _link:String;
        private var _image:String;
        private var _external:Object;

        public function DofusShopHighlight(data:Object)
        {
            super(data);
        }

        override public function init(data:Object):void
        {
            super.init(data);
            this._type = data.type;
            this._mode = data.mode;
            this._link = data.link;
            if (data.image)
            {
                if (this._mode == DofusShopEnum.HIGHLIGHT_MODE_CAROUSEL)
                {
                    this._image = data.image["667_240"];
                }
                else
                {
                    if (this._mode == DofusShopEnum.HIGHLIGHT_MODE_IMAGE)
                    {
                        this._image = data.image["208_129"];
                    };
                };
            };
            if (data.external)
            {
                if (this._type == DofusShopEnum.HIGHLIGHT_TYPE_CATEGORY)
                {
                    this._external = new DofusShopCategory(data.external);
                }
                else
                {
                    if (this._type == DofusShopEnum.HIGHLIGHT_TYPE_ARTICLE)
                    {
                        this._external = new DofusShopArticle(data.external);
                    };
                };
            };
        }

        override public function free():void
        {
            this._type = null;
            this._mode = null;
            this._link = null;
            this._image = null;
            if (((this._external) && ((this._external is DofusShopObject))))
            {
                this._external.free();
            };
            this._external = null;
            super.free();
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get mode():String
        {
            return (this._mode);
        }

        public function get link():String
        {
            return (this._link);
        }

        public function get image():String
        {
            return (this._image);
        }

        public function get external():Object
        {
            return (this._external);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.types

