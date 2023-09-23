import '../../../domain/models/transaction/transaction.dart';
import '../transaction_database.dart';

class TransactionMapper {
  TransactionMapper._();

  static Transaction toDomain(TransactionEntity entity) {
    return Transaction(
      id: entity.id,
      sum: entity.sum,
      fee: entity.fee,
      type: entity.type,
      createdAt: entity.createdAt,
    );
  }

  static TransactionEntity toEntity(Transaction transaction) {
    return TransactionEntity(
      id: transaction.id,
      sum: transaction.sum,
      fee: transaction.fee,
      type: transaction.type,
      createdAt: transaction.createdAt,
    );
  }
}
