package com.ankamagames.berilia.types.data
{
    import __AS3__.vec.Vector;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.jerakine.types.Uri;
    import __AS3__.vec.*;

    public class Map 
    {

        public var currentScale:Number;
        public var initialWidth:uint;
        public var initialHeight:uint;
        public var chunckWidth:uint;
        public var chunckHeight:uint;
        public var zoom:Number;
        private var _areas:Vector.<MapArea>;
        public var container:DisplayObjectContainer;
        public var numXChunck:uint;
        public var numYChunck:uint;

        public function Map(zoom:Number, srcFolder:String, container:DisplayObjectContainer, initialWidth:uint, initialHeight:uint, chunckWidth:uint, chunckHeight:uint)
        {
            var area:MapArea;
            var i:uint;
            super();
            this.zoom = zoom;
            this.container = container;
            this.initialHeight = initialHeight;
            this.initialWidth = initialWidth;
            this.chunckHeight = chunckHeight;
            this.chunckWidth = chunckWidth;
            container.doubleClickEnabled = true;
            this.numXChunck = Math.ceil(((initialWidth * zoom) / chunckWidth));
            this.numYChunck = Math.ceil(((initialHeight * zoom) / chunckHeight));
            this._areas = new Vector.<MapArea>((this.numXChunck * this.numYChunck), true);
            var chunckId:uint = 1;
            var j:uint;
            while (j < this.numYChunck)
            {
                i = 0;
                while (i < this.numXChunck)
                {
                    area = new MapArea(new Uri(((srcFolder + chunckId) + ".jpg")), ((i * chunckWidth) / zoom), ((j * chunckHeight) / zoom), (chunckWidth / zoom), (chunckHeight / zoom), this);
                    this.areas[(chunckId - 1)] = area;
                    chunckId++;
                    i++;
                };
                j++;
            };
        }

        public function get areas():Vector.<MapArea>
        {
            return (this._areas);
        }


    }
}//package com.ankamagames.berilia.types.data

