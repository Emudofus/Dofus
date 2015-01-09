package d2api
{
    public class DocumentApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getDocument(pDocId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getType(pDocId:uint):uint
        {
            return (0);
        }


    }
}//package d2api

