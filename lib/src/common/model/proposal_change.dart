import 'package:dart_jobs/src/common/model/proposal.dart';

/// It contains the document affected and the type of change that occurred
/// (added, modified, or removed).
abstract class ProposalChange {
  Proposal<Attribute> get proposal;

  T when<T extends Object?>({
    required T Function() added,
    required T Function() modified,
    required T Function() removed,
  });
}

/// Indicates a new document was added to the set of documents matching the
/// query.
class ProposalAdded implements ProposalChange {
  @override
  final Proposal<Attribute> proposal;

  ProposalAdded(this.proposal);

  @override
  T when<T extends Object?>({
    required T Function() added,
    required T Function() modified,
    required T Function() removed,
  }) =>
      added();

  @override
  String toString() => 'Добавлено предложение ${proposal.title}';
}

/// Indicates a document within the query was modified.
class ProposalModified implements ProposalChange {
  @override
  final Proposal<Attribute> proposal;

  ProposalModified(this.proposal);

  @override
  T when<T extends Object?>({
    required T Function() added,
    required T Function() modified,
    required T Function() removed,
  }) =>
      modified();

  @override
  String toString() => 'Изменено предложение ${proposal.title}';
}

/// Indicates a document within the query was removed (either deleted or no
/// longer matches the query.
class ProposalRemoved implements ProposalChange {
  @override
  final Proposal<Attribute> proposal;

  ProposalRemoved(this.proposal);

  @override
  T when<T extends Object?>({
    required T Function() added,
    required T Function() modified,
    required T Function() removed,
  }) =>
      removed();

  @override
  String toString() => 'Удалено предложение ${proposal.title}';
}
