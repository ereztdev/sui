module multisig101::Multisig101 {
    use sui::coin::Coin;
    use sui::sui::SUI;

    public struct Multisig has key, store {
        id: UID,
        owner: address,
        amount: u64,
    }

   public fun deposit(wallet: &mut Multisig, coin: Coin<SUI>){
        wallet.amount = wallet.amount + sui::coin::value(&coin);
        sui::coin::destroy_zero(coin);
    }

    fun init(ctx: &mut TxContext) {
        let wallet = Multisig {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            amount: 0
        };
        transfer::public_transfer(wallet, tx_context::sender(ctx));
    }
}


