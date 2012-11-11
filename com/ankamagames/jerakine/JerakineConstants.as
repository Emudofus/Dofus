package com.ankamagames.jerakine
{
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public class JerakineConstants extends Object
    {
        private var _include_IDataContainer:IDataContainer = null;
        private var _include_AsyncJPGEncoder:AsyncJPGEncoder = null;
        public static const LOADERS_POOL_INITIAL_SIZE:int = 5;
        public static const LOADERS_POOL_GROW_SIZE:int = 5;
        public static const LOADERS_POOL_WARN_LIMIT:int = 50;
        public static const URLLOADERS_POOL_INITIAL_SIZE:int = 3;
        public static const URLLOADERS_POOL_GROW_SIZE:int = 2;
        public static const URLLOADERS_POOL_WARN_LIMIT:int = 10;
        public static const RECTANGLE_POOL_INITIAL_SIZE:int = 5;
        public static const RECTANGLE_POOL_GROW_SIZE:int = 50;
        public static const RECTANGLE_POOL_WARN_LIMIT:int = 1000;
        public static const POINT_POOL_INITIAL_SIZE:int = 5;
        public static const POINT_POOL_GROW_SIZE:int = 50;
        public static const POINT_POOL_WARN_LIMIT:int = 1000;
        public static const SOUND_POOL_INITIAL_SIZE:int = 5;
        public static const SOUND_POOL_GROW_SIZE:int = 50;
        public static const SOUND_POOL_WARN_LIMIT:int = 1000;
        public static const TEXTURES_CACHE_SIZE:int = 25;
        public static const XML_CACHE_SIZE:int = 10;
        public static const MOBILES_CACHE_SIZE:int = 10;
        public static const MAX_PARALLEL_LOADINGS:uint = 6;
        public static var DATASTORE_CLASS_ALIAS:DataStoreType = new DataStoreType("Jerakine_classAlias", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static const DATASTORE_LANG:DataStoreType = new DataStoreType("Jerakine_lang", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static const DATASTORE_LANG_VERSIONS:DataStoreType = new DataStoreType("Jerakine_lang_vesrion", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static const DATASTORE_FILES_INFO:DataStoreType = new DataStoreType("Jerakine_file_version", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static const DATASTORE_MD5:DataStoreType = new DataStoreType("Jerakine_md5", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static const DATASTORE_GAME_DATA:DataStoreType = new DataStoreType("Jerakine_gameData", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);

        public function JerakineConstants()
        {
            return;
        }// end function

    }
}
