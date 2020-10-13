public class EventObjects {

        public List<Events> events;
        public Integer firstEventSequence;
        public Integer lastEventSequence;
        public String entropy;

        public class Events {
            public String resourceUrl;
            public String resourceId;
            public String eventDateUtc;
            public String eventType;
            public String eventCategory;
            public String tenantId;
            public String tenantType;
        }

    
        public static EventObjects parse(String json) {
            return (EventObjects) System.JSON.deserialize(json, EventObjects.class);
        }
}