package d2api
{
    import d2utils.ModuleFilestream;

    public class FileApi 
    {


        [Untrusted]
        public function loadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function=null):void
        {
        }

        [Trusted]
        public function trustedLoadXmlFile(url:String, loadSuccessCallBack:Function, loadErrorCallBack:Function=null):void
        {
        }

        [Untrusted]
        public function openFile(url:String, openMode:String="update"):ModuleFilestream
        {
            return (null);
        }

        [Untrusted]
        public function deleteFile(url:String):void
        {
        }

        [Untrusted]
        public function deleteDir(url:String, recursive:Boolean=true):void
        {
        }

        [Untrusted]
        public function getDirectoryContent(url:String=null, hideFiles:Boolean=false, hideDirectories:Boolean=false):Object
        {
            return (null);
        }

        [Untrusted]
        public function isDirectory(url:String):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function createDirectory(url:String):void
        {
        }

        [Untrusted]
        public function getAvaibleSpace():uint
        {
            return (0);
        }

        [Untrusted]
        public function getUsedSpace():uint
        {
            return (0);
        }

        [Untrusted]
        public function getMaxSpace():uint
        {
            return (0);
        }

        [Untrusted]
        public function getUsedFileCount():uint
        {
            return (0);
        }

        [Untrusted]
        public function getMaxFileCount():uint
        {
            return (0);
        }


    }
}//package d2api

