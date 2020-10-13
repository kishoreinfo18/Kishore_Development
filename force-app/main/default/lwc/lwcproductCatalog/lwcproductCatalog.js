import { LightningElement, wire ,track, api} from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import getproducts from '@salesforce/apex/ProductCatalogCtrl.getProducts'
import getproductDetails from '@salesforce/apex/ProductCatalogCtrl.getProductDetails'
const DELAY = 300;
export default class LwcproductCatalog extends LightningElement {
    @wire(getproducts,{whereclause : '$searchKey'})
    products;
    //@wire(getproductDetails,{productName: '$selectedValue'})
    @api productDetail;
    searchKey='';
    selectedValue='';
    handleKeyUp(event){
        debugger;
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        console.log('searchKey'+searchKey);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
        }, DELAY);
    }
    handleClick(event){
        console.log('selectedValue1'+event.target.name);
        var inputCmp = this.template.querySelector(".inputCmp").value;;
        console.log('selectedValue1£££'+inputCmp);
        var selectedValue = inputCmp;
        console.log('selectedValue12'+selectedValue);
        if(selectedValue!=='' || selectedValue!==null){
            getproductDetails({productName: selectedValue})
            .then(result => {
                this.productDetail = result;
                console.log('result'+JSON.stringify(this.productDetail));
            })
            .catch(error => {
                this.error = error;
            });
        }  
    }
}