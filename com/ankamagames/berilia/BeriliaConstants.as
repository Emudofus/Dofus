package com.ankamagames.berilia
{
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.enums.*;

    public class BeriliaConstants extends Object
    {
        public static var DATASTORE_UI_DEFINITION:DataStoreType = new DataStoreType("Berilia_ui_definition", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static var DATASTORE_UI_VERSION:DataStoreType = new DataStoreType("Berilia_ui_version", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static var DATASTORE_UI_CSS:DataStoreType = new DataStoreType("Berilia_ui_css", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_COMPUTER);
        public static var DATASTORE_BINDS:DataStoreType = new DataStoreType("Berilia_binds", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_ACCOUNT);
        public static var DATASTORE_MOD:DataStoreType = new DataStoreType("Berilia_mod", true, DataStoreEnum.LOCATION_LOCAL, DataStoreEnum.BIND_CHARACTER);
        public static var USE_UI_CACHE:Boolean = StoreDataManager.getInstance().getSetData(DATASTORE_UI_DEFINITION, "useCache", true);

        public function BeriliaConstants()
        {
            return;
        }// end function

    }
}
