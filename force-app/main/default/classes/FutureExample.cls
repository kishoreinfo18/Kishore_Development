public class FutureExample {
    public void show(){
        system.debug('show line one');
        system.debug('show line 2');
        system.debug('show line 3');
        system.debug('show line 4');
        call();
        system.debug('show line 5');
        system.debug('show line 6');
        display();
        system.debug('show line 7');
    }
    @future
    public static void call(){
        system.debug('call me one');
        system.debug('call me 2');
        system.debug('call me  3');
        system.debug('call me  4');
        system.debug('call me 5');
        system.debug('call me 6');
        system.debug('call me  7');
    }
    public void display(){
        system.debug('display one');
        system.debug('dispaly 2');
        system.debug('display  3');
    }

}