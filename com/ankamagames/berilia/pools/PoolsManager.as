package com.ankamagames.berilia.pools
{
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.utils.errors.*;

    public class PoolsManager extends Object
    {
        private var _loadersPool:Pool;
        private var _xmlParsorPool:Pool;
        private var _uiRendererPool:Pool;
        private static var _self:PoolsManager;

        public function PoolsManager()
        {
            if (_self)
            {
                throw new SingletonError("Direct initialization of singleton is forbidden. Please access PoolsManager using the getInstance method.");
            }
            return;
        }// end function

        public function getLoadersPool() : Pool
        {
            if (this._loadersPool == null)
            {
                this._loadersPool = new Pool(PoolableLoader, 1, 1, 1);
            }
            return this._loadersPool;
        }// end function

        public function getXmlParsorPool() : Pool
        {
            if (this._xmlParsorPool == null)
            {
                this._xmlParsorPool = new Pool(PoolableXmlParsor, 10, 5, 25);
            }
            return this._xmlParsorPool;
        }// end function

        public function getUiRendererPool() : Pool
        {
            if (this._uiRendererPool == null)
            {
                this._uiRendererPool = new Pool(PoolableUiRenderer, 10, 5, 25);
            }
            return this._uiRendererPool;
        }// end function

        public static function getInstance() : PoolsManager
        {
            if (_self == null)
            {
                _self = new PoolsManager;
            }
            return _self;
        }// end function

    }
}
